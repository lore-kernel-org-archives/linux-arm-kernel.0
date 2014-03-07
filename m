From: mark.roszko@gmail.com (Mark Roszko)
Date: Thu, 6 Mar 2014 23:26:45 -0500
Subject: [PATCH v2] i2c:at91: Add device tree property to set
 clock-frequency
In-Reply-To: <4A1E236E-E048-4E37-AFE8-C0AC283B73D0@jcrosoft.com>
References: <1393293045-31849-1-git-send-email-mark.roszko@gmail.com>
 <20140228110506.GF11192@ldesroches-Latitude-E6320>
 <CAJjB1qLXnO-Zkte3vg_X5ktXmj1=tG+p5BcLX9vbCgzyfg_rWA@mail.gmail.com>
 <4A1E236E-E048-4E37-AFE8-C0AC283B73D0@jcrosoft.com>
Message-ID: <CAJjB1qKriEVAQyvMaYu_N+QWJ=dzTxK91Hi_OUM8h_4i78EvbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unless I'm misunderstanding your reply, it doesn't need to be set on
each i2c device. It's meant to be an option to override the currently
hardcoded 100khz for all the at91 devices.
