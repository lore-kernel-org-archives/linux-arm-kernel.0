From: ndesaulniers@google.com (Nick Desaulniers)
Date: Thu, 26 Oct 2017 14:06:21 -0700
Subject: [PATCH] arm64: prevent regressions in compressed kernel image
 size when upgrading to binutils 2.27
In-Reply-To: <CAKwvOd=4=GOPUSYUzwkXHV2xhTzUnEpbw4c_PmFiqZBjbV80jA@mail.gmail.com>
References: <20171026202907.91852-1-ndesaulniers@google.com>
 <CAKv+Gu80ub1PnibzBtjPSOusHD-6oj4A=7ZeuW5VTv3aDQrdnQ@mail.gmail.com>
 <CAKwvOd=4=GOPUSYUzwkXHV2xhTzUnEpbw4c_PmFiqZBjbV80jA@mail.gmail.com>
Message-ID: <CAKwvOdnemSgO1Jp9B1ANhnNfu8f2xAh+wJiaLQVSAREdck3cCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ folks in Suggested-by/Reported by lines, since git send-email seems
to only pull in folks on Signed-off-by line :(

https://lkml.org/lkml/2017/10/26/590
