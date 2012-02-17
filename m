From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Feb 2012 17:51:46 +0000
Subject: [PATCH 3/3] ARM: dma-mapping: fix array out of bound access
In-Reply-To: <CAB4K4y65c+UdPMpZNSKKhz3fQO1C6no5SnMAsirQ3LvrAk3gpA@mail.gmail.com>
References: <1329494160-26942-1-git-send-email-ajeet.yadav.77@gmail.com>
 <20120217171915.GO27825@n2100.arm.linux.org.uk>
 <CAB4K4y65c+UdPMpZNSKKhz3fQO1C6no5SnMAsirQ3LvrAk3gpA@mail.gmail.com>
Message-ID: <20120217175146.GP27825@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2012 at 11:06:10PM +0530, Ajeet Yadav wrote:
> ok lets consider case that we are accessing last page of last memory mapped
> region and now analyse the for loop we will hit this case

So, come on.  Where's your analysis?
