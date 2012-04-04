From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 04 Apr 2012 12:33:14 -0600
Subject: [PATCH v4 07/10] pwm: tegra: Add device tree support
In-Reply-To: <20120404070432.GF7264@S2101-09.ap.freescale.net>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-8-git-send-email-thierry.reding@avionic-design.de>
 <4F67EE9A.6080101@wwwdotorg.org>
 <20120404070432.GF7264@S2101-09.ap.freescale.net>
Message-ID: <4F7C93EA.2010105@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2012 01:04 AM, Shawn Guo wrote:
> On Mon, Mar 19, 2012 at 08:42:34PM -0600, Stephen Warren wrote:
>> On 03/14/2012 09:56 AM, Thierry Reding wrote:
>>> Add auxdata to instantiate the PWFM controller from a device tree,
>>> include the corresponding nodes in the dtsi files for Tegra 20 and
>>> Tegra 30 and add binding documentation.
>>>
>>> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
>>
>>> +++ b/Documentation/devicetree/bindings/pwm/tegra-pwm.txt
>>
>> Can this please be named nvidia,tegra20-pwm.txt so that if we need
> 
> Is it necessary to have even the vendor prefix in the file name?  The
> file will look exceptional among all these binding documents under
> Documentation/devicetree/bindings.

It would look exceptional now, but I've had it in the back of my mind to
suggest renaming all the binding docs in line with their full compatible
value. Then, it'd just look consistent ;-P.
