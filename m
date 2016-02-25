From: heiko.carstens@de.ibm.com (Heiko Carstens)
Date: Thu, 25 Feb 2016 09:52:27 +0100
Subject: [PATCH 4/5] all: s390: move compat_wrappers.c from
 arch/s390/kernel to kernel/
In-Reply-To: <1456338854-14901-5-git-send-email-ynorov@caviumnetworks.com>
References: <1456338854-14901-1-git-send-email-ynorov@caviumnetworks.com>
 <1456338854-14901-5-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20160225085227.GD3980@osiris>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2016 at 09:34:13PM +0300, Yury Norov wrote:
> Some syscalls are declared conditionally, so corresponding wrappers
> are conditional accordingly.
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>  arch/s390/kernel/Makefile         |   2 +-
>  arch/s390/kernel/compat_wrapper.c | 129 -----------------------------
>  kernel/Makefile                   |   1 +
>  kernel/compat_wrapper.c           | 170 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 172 insertions(+), 130 deletions(-)
>  delete mode 100644 arch/s390/kernel/compat_wrapper.c
>  create mode 100644 kernel/compat_wrapper.c

Generated code looks identical on s390 and of course still works!
