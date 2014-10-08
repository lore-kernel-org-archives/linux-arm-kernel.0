From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Wed, 8 Oct 2014 14:08:29 +0545
Subject: [PATCH v9 2/2] ARM: exynos5: Add Suspend-to-RAM support for 5420
In-Reply-To: <CABxcv=k5=F7Ln2XoFtNmogOuGupWex+7V2t-TVYadah-XA8Qtg@mail.gmail.com>
References: <1412673723-15551-1-git-send-email-vikas.sajjan@samsung.com>
 <1412673723-15551-3-git-send-email-vikas.sajjan@samsung.com>
 <CABxcv=k5=F7Ln2XoFtNmogOuGupWex+7V2t-TVYadah-XA8Qtg@mail.gmail.com>
Message-ID: <CAGm_ybgAQyrJ4ni2BJPcwf72ftT4eQOJO6jeP20hKmXttn6Ltw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 7, 2014 at 6:19 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
> Hello Vikas,
>
> On Tue, Oct 7, 2014 at 11:22 AM, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
>> Adds Suspend-to-RAM support for EXYNOS5420
>>
>> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> ---
>>  arch/arm/mach-exynos/suspend.c |  151 +++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 149 insertions(+), 2 deletions(-)
>>
>
> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>

Thank you, Javier.


> Best regards,
> Javier
