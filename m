From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 29 Aug 2013 18:17:02 +0100
Subject: 3.11-rc7 big-endian support
In-Reply-To: <CAA3XUr1tW8tra+4G2Fcwsb7tasZZLfCrR8e=4j+LWUcbhQZF=Q@mail.gmail.com>
References: <1377639509-22778-1-git-send-email-ben.dooks@codethink.co.uk>
 <521D21D9.8020106@codethink.co.uk> <20130829115951.4d6df89b@skate>
 <521F2119.8080204@codethink.co.uk> <20130829122810.6f4c4e7a@skate>
 <CAA3XUr1tW8tra+4G2Fcwsb7tasZZLfCrR8e=4j+LWUcbhQZF=Q@mail.gmail.com>
Message-ID: <521F820E.5080500@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/08/13 16:53, Victor Kamensky wrote:
> Hi Ben,
>
> I wonder is it possible for you to review,
> pick up, and include into your series this patch
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/195176.html
> ([PATCH v3 0/1] ARM: signal: sigreturn_codes should be endian neutral
> to work in BE8)
>
> I think it is very much relevant to the effort.
>
> It was tested on top of your series. And as far as I know
> it is single patch outside of your series needed so BE
> Linux LTP testing result will match LE results on the
> same kernel h/w.
>
> Thanks,
> Victor

I have added it to my latest tree, and will re-post once the
reviews are in tomorrow.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
