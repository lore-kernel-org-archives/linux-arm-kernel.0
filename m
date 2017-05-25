From: keescook@chromium.org (Kees Cook)
Date: Thu, 25 May 2017 13:59:26 -0700
Subject: [PATCH] RFC: arm: eBPF JIT compiler
In-Reply-To: <CAHgaXdL0JY4DQdhAtFcMF245rqHLo+Lvt4apaSROzPGjv7pcMg@mail.gmail.com>
References: <1495564433-9750-1-git-send-email-illusionist.neo@gmail.com>
 <20170523204608.GG24807@lunn.ch>
 <CAHgaXdJH7VjS__KPOc1scN9d=wxzY0DEQHutiL3qhtQAWd-v-A@mail.gmail.com>
 <20170523232555.GY13759@lunn.ch>
 <CAHgaXdKn4J==r_22T3N_7O5oESd8xwL6L+Ot8nT9bGCsSjAkHw@mail.gmail.com>
 <20170525170051.GC18357@lunn.ch> <20170525172255.GF18357@lunn.ch>
 <CAHgaXd+CVrDEA=E2=23Qp6wk50=dBnFS6TiCtvphTBMjUywrGg@mail.gmail.com>
 <20170525182849.GG18357@lunn.ch>
 <CAHgaXdLCaTwaLiLsmkzWvzSa=67LzqwHkT6cS_CVUm9_8u2_2Q@mail.gmail.com>
 <20170525184809.GH18357@lunn.ch>
 <CAHgaXdJPSemCoaRH_5wSEE6e7sOzPg7XChuWVvykbWia4meOMw@mail.gmail.com>
 <dc6d0a88-37e1-54dd-eecc-70989e997324@gmail.com>
 <CAHgaXdL0JY4DQdhAtFcMF245rqHLo+Lvt4apaSROzPGjv7pcMg@mail.gmail.com>
Message-ID: <CAGXu5jK4LVywq0rB35wEcRAAAQubmTsPe1kTStUWmiVV-TC5wQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For what it's worth, I did an comparison of the numbers Shubham posted
in another thread for the JIT, comparing the eBPF interpreter with his
new JIT. The post is here:

https://www.spinics.net/lists/netdev/msg436402.html

-Kees

-- 
Kees Cook
Pixel Security
