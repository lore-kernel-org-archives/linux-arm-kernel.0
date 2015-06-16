From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 16 Jun 2015 08:15:10 -0300
Subject: Running kexec on mx6
In-Reply-To: <20150616094242.GR7557@n2100.arm.linux.org.uk>
References: <CAOMZO5A_=okeGhRjRb-7xkO7RJKTECdgBxinrTLtVR+6TMpnVw@mail.gmail.com>
 <CAOMZO5A0+SSdT5mfy7fmO4DUQKimQpFCSu16EVLkxR+qh6137A@mail.gmail.com>
 <CAOMZO5CvjfADx_0AhxVNwadPTb-i5LCdPTOq2ZQaYpzo-m+4Jg@mail.gmail.com>
 <CAOMZO5Br0BBSeSxtCG3aeew7ToVuBH00xEJhAsjHWRCav8+ufA@mail.gmail.com>
 <CAOMZO5DBoKXE9URxWvk+WkJEZ1RkC4S3hAyugTbd7b5Qu91QKA@mail.gmail.com>
 <CAOMZO5DOdrJdkvmtBV3Kegdxg=LVZB60qB_TvMJ-D45+1vDAHw@mail.gmail.com>
 <20150616094242.GR7557@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5B9ysnLKpCrpyN3JBUrxVT7MOh7crY3nS8MDW2Hv4Xs+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Jun 16, 2015 at 6:42 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jun 16, 2015 at 01:18:34AM -0300, Fabio Estevam wrote:
>> On Mon, Jun 15, 2015 at 7:43 PM, Fabio Estevam <festevam@gmail.com> wrote:
>>
>> > So kexec is working fine on mx6quad, but not on mx6solo.
>>
>> Also tried on mx6dl and kexec works well.
>>
>> On mx6solo I can only get kexec to work if I rebuild the kernel
>> without SMP support (CONFIG_SMP=n):
>> http://pastebin.com/nRVe3NZM
>
> Which kernel - the one which is doing the kexec, or the one being kexec'd
> into?

In my tests the kernel which is doing the kexec needs to have
CONFIG_SMP=n, so that kexec works on mx6solo.

Thanks
