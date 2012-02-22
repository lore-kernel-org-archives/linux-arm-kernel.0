From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Wed, 22 Feb 2012 23:21:13 +0530
Subject: [PATCH 1/2] ARM: S3C24XX: Move s3c2443-clock.c to mach-s3c24xx
In-Reply-To: <201202221828.53363.heiko@sntech.de>
References: <201202212221.41744.heiko@sntech.de>
 <201202212226.01189.heiko@sntech.de>
 <201202221718.01137.arnd@arndb.de>
 <201202221828.53363.heiko@sntech.de>
Message-ID: <CAJe_ZheGxcM+FsHv6hQ59hVTbes22D=5zBFsEiDzwd+wN1pK2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 February 2012 22:58, Heiko St?bner <heiko@sntech.de> wrote:
>
>> No objections on the patch, but please use 'git format-patch -M' when
>> moving files so that we can see which parts have changed in the process.
> the results of -M look really nice, thanks for the hint and I will try to
> remember it :-)
>
The -M option is as easy to forget as it is useful.
I wonder if that could be made the default with format-patch ?

-j
