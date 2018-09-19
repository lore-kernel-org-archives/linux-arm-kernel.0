From: andreyknvl@google.com (Andrey Konovalov)
Date: Wed, 19 Sep 2018 21:01:27 +0200
Subject: [PATCH v8 00/20] kasan: add software tag-based mode for arm64
In-Reply-To: <cover.1537383101.git.andreyknvl@google.com>
References: <cover.1537383101.git.andreyknvl@google.com>
Message-ID: <CAAeHK+yScE0fN2BsC_xS2TBgW+anunkOLY8P8e17V8vkT+ZKgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2018 at 8:54 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> This patchset adds a new software tag-based mode to KASAN [1].
> (Initially this mode was called KHWASAN, but it got renamed,
>  see the naming rationale at the end of this section).

Andrey, I remember you giving a Reviewed-by to this patchset, but
since there are somewhat significant naming related changes in the
last version, could you take another look? Thanks!
