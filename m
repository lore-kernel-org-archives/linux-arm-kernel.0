From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 30 Nov 2017 09:50:21 -0800
Subject: [PATCH 6/7] arm64: explicitly pass --no-fix-cortex-a53-843419 to
 GNU gold
In-Reply-To: <CAKwvOdnhdHKvkLsG+3D5KDJ+jzXeWFPd9X+eDphA4xf5NZoDnQ@mail.gmail.com>
References: <20171129234442.655-1-samitolvanen@google.com>
 <20171129234442.655-7-samitolvanen@google.com>
 <CAKwvOdnhdHKvkLsG+3D5KDJ+jzXeWFPd9X+eDphA4xf5NZoDnQ@mail.gmail.com>
Message-ID: <20171130175021.GD90451@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 04:30:33PM -0800, Nick Desaulniers wrote:
> Rather than:
> 
> if CONFIG_ARM64_ERRATUM_843419 == y:
>   ...
> if CONFIG_ARM64_ERRATUM_843419 == '':
>   ...
> 
> could this be:
> 
> if CONFIG_ARM64_ERRATUM_843419 == y:
>   ...
> else
>   ...
> 
> ?

Sure. I'll clean this up in v2.

Sami
