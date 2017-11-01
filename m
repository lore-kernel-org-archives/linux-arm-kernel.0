From: dianders@chromium.org (Doug Anderson)
Date: Tue, 31 Oct 2017 17:23:19 -0700
Subject: [RFC] Improving udelay/ndelay on platforms where that is possible
In-Reply-To: <CA+55aFwDquBXt_EYT3JFoWkeFsZTym5qUXig-DePXXzm07uABw@mail.gmail.com>
References: <d3f42f35-8175-58f6-78b7-3331efe64da2@sigmadesigns.com>
 <CA+55aFzy9=RtFRuJhFbF+PL_PCrkZsKtAKrq6WJo1z9eW9gLSA@mail.gmail.com>
 <20171031165629.GF9463@n2100.armlinux.org.uk>
 <CA+55aFwDquBXt_EYT3JFoWkeFsZTym5qUXig-DePXXzm07uABw@mail.gmail.com>
Message-ID: <CAD=FV=V3n0gjzpL860V6cgf8JVh5pmoL+i0t63Oot19T2afTPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 31, 2017 at 10:45 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> So I'm very much open to udelay improvements, and if somebody sends
> patches for particular platforms to do particularly well on that
> platform, I think we should merge them. But ...

If I'm reading this all correctly, this sounds like you'd be willing
to merge <https://patchwork.kernel.org/patch/9429841/>.  This makes
udelay() guaranteed not to underrun on arm32 platforms.

-Doug
