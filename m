From: ndesaulniers@google.com (Nick Desaulniers)
Date: Wed, 5 Sep 2018 14:55:34 -0700
Subject: [PATCH v6 00/18] khwasan: kernel hardware assisted address
 sanitizer
In-Reply-To: <20180905141032.b1ddaab53d1b2b3bada95415@linux-foundation.org>
References: <cover.1535462971.git.andreyknvl@google.com>
 <20180905141032.b1ddaab53d1b2b3bada95415@linux-foundation.org>
Message-ID: <CAKwvOdn7fG0ykS5jjKMJsDmFoV7T3g6p=YucVLxrKgewhMT=Fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 5, 2018 at 2:10 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 29 Aug 2018 13:35:04 +0200 Andrey Konovalov <andreyknvl@google.com> wrote:
>
> > This patchset adds a new mode to KASAN [1], which is called KHWASAN
> > (Kernel HardWare assisted Address SANitizer).
>
> We're at v6 and there are no reviewed-by's or acked-by's to be seen.
> Is that a fair commentary on what has been happening, or have people
> been remiss in sending and gathering such things?
>

I'm anxious to use these for Pixel Android devices.  Looks like the
series has been aggregating changes from valuable feedback.  Maybe if
the ARM maintainers and KASAN maintainers could Ack or Nack these, we
could decide to merge these or what needs more work?

-- 
Thanks,
~Nick Desaulniers
