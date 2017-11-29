From: samitolvanen@google.com (Sami Tolvanen)
Date: Wed, 29 Nov 2017 08:22:23 -0800
Subject: [PATCH 3/3] arm64: use -mno-implicit-float instead of
 -mgeneral-regs-only
In-Reply-To: <CAKv+Gu99XM5jLcOTkqPJPj5oZnUCNv2c7C=5X2hFCM4-4_gwNg@mail.gmail.com>
References: <20171129000011.55235-1-samitolvanen@google.com>
 <20171129000011.55235-4-samitolvanen@google.com>
 <CAKv+Gu99XM5jLcOTkqPJPj5oZnUCNv2c7C=5X2hFCM4-4_gwNg@mail.gmail.com>
Message-ID: <20171129162223.GA2959@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 12:15:14PM +0000, Ard Biesheuvel wrote:
> Do we still need these patches now that the AES code has been fixed?

With your AES patch that Herbert just applied, this patch is no longer
needed. Version macros in the first two patches will still be useful in
future though.

Sami
