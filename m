From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 16 Jun 2015 09:46:46 -0300
Subject: Running kexec on mx6
In-Reply-To: <CAOMZO5B9ysnLKpCrpyN3JBUrxVT7MOh7crY3nS8MDW2Hv4Xs+A@mail.gmail.com>
References: <CAOMZO5A_=okeGhRjRb-7xkO7RJKTECdgBxinrTLtVR+6TMpnVw@mail.gmail.com>
 <CAOMZO5A0+SSdT5mfy7fmO4DUQKimQpFCSu16EVLkxR+qh6137A@mail.gmail.com>
 <CAOMZO5CvjfADx_0AhxVNwadPTb-i5LCdPTOq2ZQaYpzo-m+4Jg@mail.gmail.com>
 <CAOMZO5Br0BBSeSxtCG3aeew7ToVuBH00xEJhAsjHWRCav8+ufA@mail.gmail.com>
 <CAOMZO5DBoKXE9URxWvk+WkJEZ1RkC4S3hAyugTbd7b5Qu91QKA@mail.gmail.com>
 <CAOMZO5DOdrJdkvmtBV3Kegdxg=LVZB60qB_TvMJ-D45+1vDAHw@mail.gmail.com>
 <20150616094242.GR7557@n2100.arm.linux.org.uk>
 <CAOMZO5B9ysnLKpCrpyN3JBUrxVT7MOh7crY3nS8MDW2Hv4Xs+A@mail.gmail.com>
Message-ID: <CAOMZO5BYCNuQ=5zHurf6Zqmpwcj1tiCZj7Nj4j6ygijbePNBFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 8:15 AM, Fabio Estevam <festevam@gmail.com> wrote:

>> Which kernel - the one which is doing the kexec, or the one being kexec'd
>> into?
>
> In my tests the kernel which is doing the kexec needs to have
> CONFIG_SMP=n, so that kexec works on mx6solo.

Other combination that works is to have CONFIG_SMP=y and then pass
'nosmp' in the kernel command line, or also by removing cpu1 from the
imx6dl.dtsi.
