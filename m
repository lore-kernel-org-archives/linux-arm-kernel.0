From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 16 Aug 2013 17:17:18 -0600
Subject: [PATCH RFC 3/3] spmi: document the PMIC arbiter SPMI bindings
In-Reply-To: <A1FAB0A0-C205-4401-838C-B745B5B95FF3@codeaurora.org>
References: <cover.1376596224.git.joshc@codeaurora.org>
 <b639088d50df93caaef8fe7e09c12953b1153ce8.1376596224.git.joshc@codeaurora.org>
 <D1534646-7CB5-4EE7-8C1E-1C607BE22396@codeaurora.org>
 <20130816192549.GG4035@joshc.qualcomm.com>
 <A1FAB0A0-C205-4401-838C-B745B5B95FF3@codeaurora.org>
Message-ID: <520EB2FE.2030903@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/16/2013 01:48 PM, Kumar Gala wrote:
> 
> On Aug 16, 2013, at 2:25 PM, Josh Cartwright wrote:
> 
>> Hey Kumar-
>>
>> Thanks for the review.
>>
>> On Fri, Aug 16, 2013 at 01:53:27PM -0500, Kumar Gala wrote:
>>> On Aug 9, 2013, at 3:37 PM, Josh Cartwright wrote:
>>>
>>>> Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
>>>> ---
>>>> .../devicetree/bindings/spmi/spmi-pmic-arb.txt     | 26 ++++++++++++++++++++++
>>>> 1 file changed, 26 insertions(+)
>>>> create mode 100644 Documentation/devicetree/bindings/spmi/spmi-pmic-arb.txt
>>>
>>> As this is a qcom specific binding, I think the file name should be msm-spmi-pmic-arb.txt or something like that.
>>
>> Agreed.  It might be nice to use a vendor prefix in the name too.  How's qcom,msm-pmic-arb.txt sound?
> 
> Sounds good, as I see we have other examples of having a comma in file names for bindings.

The rule I've applied for bindings I created is use the complete
compatible value for the file name. Where multiple are supported (e.g.
SoC versions), just use the first one. Then, the filename is pretty
unambiguous, both from a point of view of `ls` and from choosing a name.
