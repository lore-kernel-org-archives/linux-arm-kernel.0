From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sat, 23 Feb 2013 16:52:56 -0700
Subject: [v3 0/6] ARM: tegra: convert device tree files to use CLK defines
In-Reply-To: <1361649074.11282.12@driftwood>
References: <1360917814-27236-1-git-send-email-hdoyu@nvidia.com>
 <1361138717.29465.2@driftwood> <5123B1F8.4040102@wwwdotorg.org>
 <1361649074.11282.12@driftwood>
Message-ID: <51295658.7030105@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/23/2013 12:51 PM, Rob Landley wrote:
> On 02/19/2013 11:10:16 AM, Stephen Warren wrote:
>> On 02/17/2013 03:05 PM, Rob Landley wrote:
>> > On 02/15/2013 02:43:11 AM, Hiroshi Doyu wrote:
>> >> Hi,
>> >>
>> >> With new dtc+cpp feature, we could get rid of magic numbers in dts*
>> >> files. This patch replaces CLK IDs.
>> >>
>> >> We also plan to share those DT header files with kernel source
>> >> later[1].
>> > ...
>> >> [1]
>> >>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-February/149804.html
>>
>> >>
>> >
>> > This really smells like documentation should be updated, probably
>> > booting-without-of.txt or similar. Alas, I'm not capable of writing
>> such
>> > an update...
>>
>> I'm not sure what documentation would be updated nor why. Can you
>> describe that?
> 
> "When writing new device tree files, please do not include magic
> numbers. Here's how to avoid them."
> 
> Does something in Documentation already say this somewhere?

This seems rather basic and not worth documenting. The technique is
identical to the use of header files in C/assembly/... code. I suppose
if we document that, then there would be an argument for documenting this.
