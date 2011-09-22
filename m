From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 Sep 2011 17:19:40 +0200
Subject: [PATCH v2 3/3] ARM: CSR: PM: add sleep entry for SiRFprimaII
In-Reply-To: <CAGsJ_4zY=J5w5st5P1gYonPata4maWb7Phe1Gohf_qjgDxxbnw@mail.gmail.com>
References: <1316618267-4348-1-git-send-email-21cnbao@gmail.com>
	<1316618267-4348-4-git-send-email-21cnbao@gmail.com>
	<CAGsJ_4zY=J5w5st5P1gYonPata4maWb7Phe1Gohf_qjgDxxbnw@mail.gmail.com>
Message-ID: <201109221719.40279.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 September 2011, Barry Song wrote:
> 2011/9/21 Barry Song <21cnbao@gmail.com>:
> > From: Rongjun Ying <rongjun.ying@csr.com>
> >
> > This patch adds suspend-to-mem support for prima2. It will make prima2
> > enter DEEPSLEEP mode while accepting PM_SUSPEND_MEM command.
> >
> > Signed-off-by: Rongjun Ying <baohua.song@csr.com>
> 
> sorry for typo. it should be:
> Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
> 
> this was fixed in repository for pull.

Ok, I've made sure I have the right version.

	Arnd
