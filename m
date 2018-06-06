From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 6 Jun 2018 10:32:50 -0700
Subject: [PATCH] ARM: dts: cygnus: Add HWRNG node
In-Reply-To: <676106a4-d763-725c-2342-f8d215fbd169@broadcom.com>
References: <20180606093441.16483-1-peron.clem@gmail.com>
 <c8836130-1d96-b813-4e87-5011db679ba8@broadcom.com>
 <c7990001-00e6-d828-bafd-3d472fcfee20@gmail.com>
 <676106a4-d763-725c-2342-f8d215fbd169@broadcom.com>
Message-ID: <d2d81ba8-5e25-0b23-339a-fd079daa120c@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2018 10:14 AM, Scott Branden wrote:
> 
> 
> On 18-06-06 09:47 AM, Florian Fainelli wrote:
>> On 06/06/2018 09:03 AM, Scott Branden wrote:
>>> Hi Clement,
>>>
>>>
>>> On 18-06-06 02:34 AM, Cl?ment P?ron wrote:
>>>> From: Cl?ment Peron <clement.peron@devialet.com>
>>>>
>>>> There is a HWRNG in Broadcom Cygnus SoC, so enable it.
>>>>
>>>> Signed-off-by: Cl?ment Peron <clement.peron@devialet.com>
>>> Thanks for upstreaming some missing Cygnus components.
>>>
>>> But, the problem is the tarball release from Broadcom you are extracting
>>> these changes from does not contain git history; so, you are missing the
>>> original authors and signed-off's.
>>> I checked our internal git repository and for this commit the author is:
>>> Mohamed Ismail Abdul Packir Mohamed <mohamed-ismail.abdul@broadcom.com>
>>>
>>> Please adjust author and signed-off appropriately.? If there are other
>>> changes you are extracting from the source tarballs you have please
>>> contact me so we can construct patch appropriately.
>> If you want the original author's Signed-off-by to be preserved, why
>> don't you extract it from your internal git tree and submit the patch on
>> Mohamed's behalf?
> Sure, I can submit the original patch to keep things simple and avoid
> finding a lawyer right now.
>>
>> AFAICT what Clement is doing here is permissible given the Linux
>> developer certificate of origin though I am not a lawyer of course.
> But, It would be great to get some guidance and clarification on this
> for sure.
> I'm reading:
> https://www.kernel.org/doc/html/v4.16/process/submitting-patches.html
> 
> The change was created entirely by Broadcom, so seems difficult for
> somebody else to upstream change without appropriate authorship and
> signed off from copyright holder.

Indeed, but it is effectively Broadcom's fault for not providing a git
tree for the customer to pull from in order to preserve the original
authorship, if what was distributed is a tarball of changes against a
vanilla kernel (which is likely to be the case), then all author
attributions are lost.

Not suggesting you change how you deliver code to customers, we have the
same issue in the STB/CM group, except maybe customers care less about
upstreaming so we can do it ourselves at our own pace and using our own
attributions.

> Point a) and b) are not met in
> Developer's Certificate of Origin while point c) is being attempted
> (without a or b being certified).

I would think that point a) and b) are met by the very fact that the
Cygnus kernel port is GPLv2 code, being a derivative work of the Linux
kernel, and that should be enough.

This is kind of well established things, this has happened for many
Broadcom product lines unfortunately because not everyone is active like
you in getting things upstreamed. Those contributions were still
entirely valid and acceptable for the kernel community.

Maybe we do need a lawyer, Saul Goodman, are you here?
-- 
Florian
