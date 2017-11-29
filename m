From: ndesaulniers@google.com (Nick Desaulniers)
Date: Wed, 29 Nov 2017 09:19:11 -0800
Subject: [PATCH 2/3] kbuild: add cc-if-name-version and compiler-specific
 variants
In-Reply-To: <20171129000011.55235-3-samitolvanen@google.com>
References: <20171129000011.55235-1-samitolvanen@google.com>
 <20171129000011.55235-3-samitolvanen@google.com>
Message-ID: <CAKwvOdkNBozCM0k+ENkMOPXC45BJYZzBWZwTAoJ8GAL8di-e=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We could use something like this to warn people trying to build the
kernel with clang-3.8 for instance.
