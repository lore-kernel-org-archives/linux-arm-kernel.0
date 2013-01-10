From: mchehab@redhat.com (Mauro Carvalho Chehab)
Date: Thu, 10 Jan 2013 14:06:11 -0200
Subject: [PATCH v5] modify videobuf2-dma-contig and update sta2x11_vip
In-Reply-To: <1491201.YT9CD19YNt@harkonnen>
References: <1357822010-30419-1-git-send-email-federico.vaga@gmail.com>
 <1491201.YT9CD19YNt@harkonnen>
Message-ID: <20130110140611.05feb735@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Thu, 10 Jan 2013 16:22:39 +0100
Federico Vaga <federico.vaga@gmail.com> escreveu:

> We have some new ideas for this new complex architecture (sta2x11) that can 
> fix our DMA problems without change the existent code. Obviously, ideas arrive 
> when I already sent the patches. Anyway, consider this patch series as an RFC. 
> They are not ready for the mainline. I take some time to investigate on the 
> architecture side of the project to try to fix our problem.
> 
> Anyway, if you consider interesting configure the gfp flags for dma-contig, I 
> can propose a v6 series which correct the alloc coherent line.
> 
> Sorry for the spam :(

This is not spam, it is part of the process of maturating a patchset ;)

I'll just tag all those patches as RFC on linux-media patchwork.

Regards,
Mauro
