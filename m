From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 5 Nov 2013 21:35:53 -0200
Subject: [PATCH v4] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <CAHCPf3s-dxzqAGHhOaemJeCW0LmxOhYThrtif+QpGb4LzeWDpg@mail.gmail.com>
References: <1383181127-12013-1-git-send-email-festevam@gmail.com>
 <5272BC59.1080109@boundarydevices.com>
 <5272BFE0.5040409@boundarydevices.com>
 <CAOMZO5C39JNVv0vz-38eOrKHXMqWHCeCknhSvfGFe5t0EGkDsg@mail.gmail.com>
 <20131031210053.GH16735@n2100.arm.linux.org.uk>
 <CAOMZO5DAAXg4wP2UuYCN6BgN5-q3sv0Lrqvk8xMDmEW_TXepXg@mail.gmail.com>
 <CAHCPf3v0G_551Oeq-dL61J0Ce-iUMv+ou8+q671S8=GEcNjv5w@mail.gmail.com>
 <CAHCPf3tSdn=TJ86QEtL3r9iSP0j88WP-y2=z96ZUfW-7VecMbQ@mail.gmail.com>
 <CAOMZO5DU9y2tvgkEbastQdhJvtLGLJ-b49WY8RsvpbmJhzMxLA@mail.gmail.com>
 <CAHCPf3s-dxzqAGHhOaemJeCW0LmxOhYThrtif+QpGb4LzeWDpg@mail.gmail.com>
Message-ID: <CAOMZO5DTB085wL1NOwGF5EynoQh1r2_ztR754dLrf1EMOuN75g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 5, 2013 at 9:29 PM, Matt Sealey <neko@bakuhatsu.net> wrote:

> I know about that one. BTW this isn't in the MX6SDL errata
> documentation, but it is in the MX6QD errata. If this actually affects
> the Solo etc. as Russell dictates, isn't the errata document missing
> some info here?

If you read the code you will notice that the multiple writes affects
only mx6quad.
