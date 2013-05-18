From: a.spyridakis@virtualopensystems.com (Alexander Spyridakis)
Date: Sat, 18 May 2013 15:22:07 +0300
Subject: Problems while booting a linux system on fast models based
 CortexA15
In-Reply-To: <CAJ30i6F542sn_+_6ha-nf-kgS7u=OMBTE6DY1tmZPihLbEptxQ@mail.gmail.com>
References: <CAJ30i6HzvaKrKha7aVcR50=-5zmgivY-82J6NTqFw7Fh+sNzfQ@mail.gmail.com>
 <CAEDV+gLekd9PrX=YqFpKQyLxFHDuAV8F5NvaMkRKZQvR3q_yNg@mail.gmail.com>
 <CAJ30i6G95VHv5FoP5DXXBNgp+qxbJ-2ZyvXy8eNa_pM7xx6r-Q@mail.gmail.com>
 <CAJRNFKKwaE-JCvj52B5oba+hvYeTn3W5Qo5TOPGSSy=WfFE-fA@mail.gmail.com>
 <CAJ30i6F542sn_+_6ha-nf-kgS7u=OMBTE6DY1tmZPihLbEptxQ@mail.gmail.com>
Message-ID: <CAJRNFKJNArk+1qa9HyjmLFVqX=WP2_TpZOyAr_Qpeux9Cc7ukg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 May 2013 03:26, Mai Daftedar <mai.daftedar@gmail.com> wrote:
>
> I still have no luck in bringing up the host on fast models.
> There is something I'm definitely missing out :
>
> Theses are my suggested potential errors:
> When I execute the following command as mentioned in the pdf
> mkfs.ext3 ./disk.img
>
> The following occurs..Is this okay?

Ah yes sorry for that, try and apply this temporary fix to boot from the MMC:
https://github.com/virtualopensystems/linux-kvm-arm/commit/17a9b9221998802d1ee2b245818cdd253ccbdab6

In the longterm though I suggest to fix your networking problem, it is
much easier to test things out with NFS.

Regards.
