From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 12 Aug 2013 13:29:56 +0800
Subject: [PATCH v2] dmaengine: sirf: add PM entries for sleep and runtime
In-Reply-To: <1375177474-27583-1-git-send-email-Baohua.Song@csr.com>
References: <1375177474-27583-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <CAGsJ_4xPhq3B1vcKy8peGyEsFPF7mSt3H-EW3Ne7qesStFO_9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/30 Barry Song <21cnbao@gmail.com>:
> this patch adds PM ops entries in sirf-dma drivers, so that this
> driver can support suspend/resume, hibernation and runtime PM.
>
> while suspending, sirf-dma will lose all registers, so we save
> them at suspend and restore in resume for active channels.
>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>

ping Vinod.

-barry
