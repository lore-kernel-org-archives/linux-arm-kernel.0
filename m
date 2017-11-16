From: ndesaulniers@google.com (Nick Desaulniers)
Date: Thu, 16 Nov 2017 08:44:38 -0800
Subject: [PATCH v2 11/18] arm64: make mrs_s and msr_s macros work with LTO
In-Reply-To: <20171116164306.GF94341@samitolvanen.mtv.corp.google.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-12-samitolvanen@google.com>
 <20171116115433.GG9361@arm.com>
 <20171116164306.GF94341@samitolvanen.mtv.corp.google.com>
Message-ID: <CAKwvOdkKA7PhRx-D0ofZgydbcga87FB1C4Q0A4fosK-BN-Raiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I need this patch to assemble the kernel for arm64 with clang regardless of LTO.
