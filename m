From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Jun 2012 11:39:44 +0100
Subject: [RFC 03/34] dmaengine: virt-dma: add support for cyclic DMA
 periodic callbacks
In-Reply-To: <CAMj5Bkgca-KQ1xPDjeS6uskYN_jbLQRbQBtuPBz7teWz064aOw@mail.gmail.com>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIqg-0006yu-5Z@rmk-PC.arm.linux.org.uk>
 <CACRpkdba_aFbyBt9hkYqBR=oY6fq0KHchjGcuS_NhbOMbE0Owg@mail.gmail.com>
 <20120530080216.GH12217@n2100.arm.linux.org.uk>
 <CAMj5BkjGQXxA0gaNLKDSuRpYXoY3sqbzquKo-Lth9-TG_QcqHQ@mail.gmail.com>
 <20120531191757.GI12217@n2100.arm.linux.org.uk>
 <CAMj5Bkgca-KQ1xPDjeS6uskYN_jbLQRbQBtuPBz7teWz064aOw@mail.gmail.com>
Message-ID: <20120601103944.GA21245@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 01, 2012 at 10:26:37AM +0800, zhangfei gao wrote:
> Could we directly treat dma_tx_state.residue as "how many periods have expired"

Why change the behaviour and add complexity to _both_ sides of the API,
as well as confusion about what "residue" means?
