From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 6 Jun 2018 09:47:12 -0700
Subject: [PATCH] ARM: dts: cygnus: Add HWRNG node
In-Reply-To: <c8836130-1d96-b813-4e87-5011db679ba8@broadcom.com>
References: <20180606093441.16483-1-peron.clem@gmail.com>
 <c8836130-1d96-b813-4e87-5011db679ba8@broadcom.com>
Message-ID: <c7990001-00e6-d828-bafd-3d472fcfee20@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2018 09:03 AM, Scott Branden wrote:
> Hi Clement,
> 
> 
> On 18-06-06 02:34 AM, Cl?ment P?ron wrote:
>> From: Cl?ment Peron <clement.peron@devialet.com>
>>
>> There is a HWRNG in Broadcom Cygnus SoC, so enable it.
>>
>> Signed-off-by: Cl?ment Peron <clement.peron@devialet.com>
> Thanks for upstreaming some missing Cygnus components.
> 
> But, the problem is the tarball release from Broadcom you are extracting
> these changes from does not contain git history; so, you are missing the
> original authors and signed-off's.
> I checked our internal git repository and for this commit the author is:
> Mohamed Ismail Abdul Packir Mohamed <mohamed-ismail.abdul@broadcom.com>
> 
> Please adjust author and signed-off appropriately.? If there are other
> changes you are extracting from the source tarballs you have please
> contact me so we can construct patch appropriately.

If you want the original author's Signed-off-by to be preserved, why
don't you extract it from your internal git tree and submit the patch on
Mohamed's behalf?

AFAICT what Clement is doing here is permissible given the Linux
developer certificate of origin though I am not a lawyer of course.
-- 
Florian
