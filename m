From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 23 Feb 2015 15:27:21 +0100
Subject: stand-alone kvmtool
In-Reply-To: <54E5C16D.3060109@oracle.com>
References: <54DDD465.3050300@arm.com>
 <54E5C16D.3060109@oracle.com>
Message-ID: <20150223142721.GC5609@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 19, 2015 at 05:56:45AM -0500, Sasha Levin wrote:

[...]

> 
> What inconvenience is caused by having it sit inside the kernel tree
> beyond an increased requirement in disk space?
> 
FWIW: I would prefer seeing this outside the kernel tree; I think it is
slightly confusing to keep it as part of a non-upstream kernel repo and
it is simpler to view git change logs etc. in gitweb for a stand-alone
repo.

-Christoffer
