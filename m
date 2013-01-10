From: federico.vaga@gmail.com (Federico Vaga)
Date: Thu, 10 Jan 2013 16:22:39 +0100
Subject: [PATCH v5] modify videobuf2-dma-contig and update sta2x11_vip
In-Reply-To: <1357822010-30419-1-git-send-email-federico.vaga@gmail.com>
References: <1357822010-30419-1-git-send-email-federico.vaga@gmail.com>
Message-ID: <1491201.YT9CD19YNt@harkonnen>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have some new ideas for this new complex architecture (sta2x11) that can 
fix our DMA problems without change the existent code. Obviously, ideas arrive 
when I already sent the patches. Anyway, consider this patch series as an RFC. 
They are not ready for the mainline. I take some time to investigate on the 
architecture side of the project to try to fix our problem.

Anyway, if you consider interesting configure the gfp flags for dma-contig, I 
can propose a v6 series which correct the alloc coherent line.

Sorry for the spam :(

-- 
Federico Vaga
