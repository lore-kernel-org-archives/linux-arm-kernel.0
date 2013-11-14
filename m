From: gang.chen@asianux.com (Chen Gang)
Date: Thu, 14 Nov 2013 10:41:35 +0800
Subject: [PATCH] arch: arm: uapi: be sure of "_UAPI" prefix for all guard
 macros
In-Reply-To: <527C5ECD.8010208@asianux.com>
References: <527C5ECD.8010208@asianux.com>
Message-ID: <5284385F.4030904@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2013 11:47 AM, Chen Gang wrote:
> For all uapi headers, need use "_UAPI" prefix for its guard macro
> (which will be stripped by "scripts/headers_installer.sh").
> 
> Additional completions:
> 
>  - be sure that all "endif" need be appended related comment, also it
>    has and only has one empty line above and no any lines below either.
> 
>  - be sure that all normal uapi header files need content guard macro.
> 
>  - remove the default "kvm_para.h" which was added in Kbuild.

Oh, sorry, it should use 'generic-y' instead of 'header-y' in Kbuild. I
will send patch v2 for it.

> 
>  - remove the detail address of Free Software Foundation (or can not
>    pass "scripts/checkpatch.pl").
> 

Thanks.
-- 
Chen Gang
