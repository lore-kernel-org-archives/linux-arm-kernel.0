From: msalter@redhat.com (Mark Salter)
Date: Thu, 05 Dec 2013 10:52:41 -0500
Subject: [PATCH 3/3] arm64: add EFI runtime services
In-Reply-To: <20131205152510.GB974@darko.cambridge.arm.com>
References: <1385762712-17043-1-git-send-email-msalter@redhat.com>
 <1385762712-17043-4-git-send-email-msalter@redhat.com>
 <20131205152510.GB974@darko.cambridge.arm.com>
Message-ID: <1386258761.1861.137.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-12-05 at 15:25 +0000, Catalin Marinas wrote:
> I lost track of the early_ioremap status for arm/arm64? Was there more
> progress since October (I think)?

See the two patch series:

 https://lkml.org/lkml/2013/11/25/474

and

 https://lkml.org/lkml/2013/11/27/621

The latter early_ioremap depends on the first although there are no
arm64 bits in the first. All of the arm64 early_ioremap stuff is in
the latter.

--Mark
