From: broonie@kernel.org (Mark Brown)
Date: Thu, 7 May 2015 10:46:39 +0100
Subject: [PATCH 1/2] spi: sirf: replace kmalloc by devm_kzalloc
In-Reply-To: <1430982791-8681-1-git-send-email-21cnbao@gmail.com>
References: <1430982791-8681-1-git-send-email-21cnbao@gmail.com>
Message-ID: <20150507094639.GJ22845@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 07, 2015 at 07:13:10AM +0000, Barry Song wrote:
> From: Qipan Li <Qipan.Li@csr.com>
> 

Applied since it's an improvement but please do update to use the core
features like Geert suggested.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150507/944ff8c7/attachment.sig>
