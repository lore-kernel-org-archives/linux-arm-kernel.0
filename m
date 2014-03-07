From: mark.roszko@gmail.com (Mark Roszko)
Date: Fri, 7 Mar 2014 00:30:37 -0500
Subject: [PATCH v2] i2c:at91: Add device tree property to set
 clock-frequency
In-Reply-To: <05EF9B59-7009-49D2-B57F-5612C39F1FF0@jcrosoft.com>
References: <1393293045-31849-1-git-send-email-mark.roszko@gmail.com>
 <20140228110506.GF11192@ldesroches-Latitude-E6320>
 <CAJjB1qLXnO-Zkte3vg_X5ktXmj1=tG+p5BcLX9vbCgzyfg_rWA@mail.gmail.com>
 <4A1E236E-E048-4E37-AFE8-C0AC283B73D0@jcrosoft.com>
 <CAJjB1qKriEVAQyvMaYu_N+QWJ=dzTxK91Hi_OUM8h_4i78EvbA@mail.gmail.com>
 <05EF9B59-7009-49D2-B57F-5612C39F1FF0@jcrosoft.com>
Message-ID: <CAJjB1qJwa-x6yTAyEK8ByU4MNHnRgRpM4oYOFZFDm5Mi1wPHtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ah, you are talking about the individual slave devices within an
device tree i2c bus like the i2c eeproms? Yea, it would be nicer if
one could define it as such to deal with having slave devices that
can't handle certain speeds such as I have. This patch does work
though nicely for my needs with an SAMA5 with three i2c buses running
at 50kHz, 100kHz and 400kHz separately.
