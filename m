From: olof@lixom.net (Olof Johansson)
Date: Fri, 31 Jan 2014 15:15:29 -0800
Subject: [PATCH] drivers: bus: fix CCI driver kcalloc call parameters swap
In-Reply-To: <1390819837-32196-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1390819837-32196-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20140131231529.GB11138@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 10:50:37AM +0000, Lorenzo Pieralisi wrote:
> This patch fixes a bug/typo in the CCI driver kcalloc usage
> that inadvertently swapped the parameters order in the
> kcalloc call and went unnoticed.
> 
> Reported-by: Xia Feng <xiafeng@allwinnertech.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Applied, thanks.


-Olof
