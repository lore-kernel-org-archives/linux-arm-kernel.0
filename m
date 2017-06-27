From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 27 Jun 2017 14:36:46 +0000
Subject: [STABLE REQ] mm/vmalloc.c: huge-vmap: fail gracefully on unexpected
 huge vmap mappings
Message-ID: <CAKv+Gu8yGfECvJj8NhvfqRzDGZ5FrATeQDJAcASot+u+hq31zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please consider

029c54b09599 mm/vmalloc.c: huge-vmap: fail gracefully on unexpected
huge vmap mappings

for inclusion into the v4.9 and v4.11 stable trees. It prevents
crashes on arm64 that may occur after commit 324420bf91f6 ("arm64: add
support for ioremap() block mappings") was merged for v4.6.

-- 
Ard.
