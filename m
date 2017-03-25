From: balbi@kernel.org (Felipe Balbi)
Date: Sat, 25 Mar 2017 09:51:28 +0200
Subject: [PATCH 0/7] dwc3 - bug fixes and use meaningful goto labels
In-Reply-To: <cover.1490387086.git.shuahkh@osg.samsung.com>
References: <cover.1490387086.git.shuahkh@osg.samsung.com>
Message-ID: <87poh523r3.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Shuah Khan <shuahkh@osg.samsung.com> writes:
> This patch series consists of two fixes and changes to goto labels

we *NEVER* put cleanups and fixes together.

> to use meaningful names.
>
> While working on goto label changes, I noticed  put_sync calls without
> successful get_sync in error legs.  The first two patches are the fixes
> and the rest of the patches are goto label changes.

so, you mean to say that you're adding regressions because you *THOUGHT*
there was a bug there, right? Read the docs ;-)

-- 
balbi
