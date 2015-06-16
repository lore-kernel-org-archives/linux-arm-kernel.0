From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Tue, 16 Jun 2015 16:08:10 -0700
Subject: [PATCH 0/3] ARM: Allow SPARSEMEM on multiplatform build
In-Reply-To: <1433469518-8472-1-git-send-email-gregory.0xf0@gmail.com>
References: <1433469518-8472-1-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <CADtm3G787qktjwL-u92xVaLak2f6ZGCOQHd0dCVhp1n1eziwsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 4, 2015 at 6:58 PM, Gregory Fong <gregory.0xf0@gmail.com> wrote:
> This is based on the changeset submitted by Kevin Cernekee last September:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/286835.html
>
> The changes I have made are:
> - update commit messages per review comments from Arnd and Russell
> - change to allow FLATMEM or SPARSEMEM on all multiplatform builds, not just
>   multi-v7
>
> Gregory Fong (1):
>   ARM: Allow either FLATMEM or SPARSEMEM on the multiplatform build
>
> Kevin Cernekee (2):
>   ARM: Add default SPARSEMEM settings
>   ARM: Remove redundant ARCH_SPARSEMEM_DEFAULT setting

Russell, should I add these to your patch tracker?
