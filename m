From: dianders@chromium.org (Doug Anderson)
Date: Wed, 25 Jun 2014 10:00:57 -0700
Subject: [PATCH 4/4] ARM: DTS: Add NTC thermistor nodes as child nodes to
 ADC
In-Reply-To: <CAHfPSqAAWFtCQQrKBhLFuE2OuO_fwmUOhcOX9zKk8eMRMNSVvg@mail.gmail.com>
References: <1403612356-23685-1-git-send-email-ch.naveen@samsung.com>
 <1403612356-23685-5-git-send-email-ch.naveen@samsung.com>
 <CAD=FV=Wmi73S4c5TPUqnNyycQ5xX5SbYy_ES-cbbJF2Hr0tqvQ@mail.gmail.com>
 <CAHfPSqAAWFtCQQrKBhLFuE2OuO_fwmUOhcOX9zKk8eMRMNSVvg@mail.gmail.com>
Message-ID: <CAD=FV=VnHZY3vC6y3B-3xXMnYCV+UVrCcgT5y73FJEuKdot_Sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Naveen,

On Tue, Jun 24, 2014 at 10:04 PM, Naveen Krishna Ch
<naveenkrishna.ch@gmail.com> wrote:
> Also, we have few similar nodes on Peach PI  and Peach PIT.
> Any plans or discussion on merging the common nodes ?

There was some discussion about this in another thread with Javier.
We were thinking of doing more "config fragments" like I did for the
keyboard.  See <https://lkml.org/lkml/2014/6/24/337> for context.

If someone wants to try to break some config fragments out feel free
to send up patches.  Until that is done let's at least keep pit and pi
as close to the same as possible (try to add features to both and try
to make sure that "diff" between the two looks good).

-Doug
