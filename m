From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 4 Nov 2013 23:13:04 -0200
Subject: [PATCH v4] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <CAHCPf3tSdn=TJ86QEtL3r9iSP0j88WP-y2=z96ZUfW-7VecMbQ@mail.gmail.com>
References: <1383181127-12013-1-git-send-email-festevam@gmail.com>
 <5272BC59.1080109@boundarydevices.com>
 <5272BFE0.5040409@boundarydevices.com>
 <CAOMZO5C39JNVv0vz-38eOrKHXMqWHCeCknhSvfGFe5t0EGkDsg@mail.gmail.com>
 <20131031210053.GH16735@n2100.arm.linux.org.uk>
 <CAOMZO5DAAXg4wP2UuYCN6BgN5-q3sv0Lrqvk8xMDmEW_TXepXg@mail.gmail.com>
 <CAHCPf3v0G_551Oeq-dL61J0Ce-iUMv+ou8+q671S8=GEcNjv5w@mail.gmail.com>
 <CAHCPf3tSdn=TJ86QEtL3r9iSP0j88WP-y2=z96ZUfW-7VecMbQ@mail.gmail.com>
Message-ID: <CAOMZO5DU9y2tvgkEbastQdhJvtLGLJ-b49WY8RsvpbmJhzMxLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 4, 2013 at 9:20 PM, Matt Sealey <neko@bakuhatsu.net> wrote:

> Fabio, Shawn, could you go so far as to bring this up with the i.MX
> guys responsible for documentation or find the original transmitter IP
> specs, or find the two pages missing from the manual? This is a really

The multiple writes comes from the following erratum:
ERR005173 HDMI: Clarification on HDMI programming procedure to avoid
FIFO overflow

Regards,

Fabio Estevam
