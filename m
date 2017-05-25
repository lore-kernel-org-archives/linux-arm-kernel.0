From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 25 May 2017 20:28:49 +0200
Subject: [PATCH] RFC: arm: eBPF JIT compiler
In-Reply-To: <CAHgaXd+CVrDEA=E2=23Qp6wk50=dBnFS6TiCtvphTBMjUywrGg@mail.gmail.com>
References: <1495564433-9750-1-git-send-email-illusionist.neo@gmail.com>
 <20170523204608.GG24807@lunn.ch>
 <CAHgaXdJH7VjS__KPOc1scN9d=wxzY0DEQHutiL3qhtQAWd-v-A@mail.gmail.com>
 <20170523232555.GY13759@lunn.ch>
 <CAHgaXdKn4J==r_22T3N_7O5oESd8xwL6L+Ot8nT9bGCsSjAkHw@mail.gmail.com>
 <20170525170051.GC18357@lunn.ch> <20170525172255.GF18357@lunn.ch>
 <CAHgaXd+CVrDEA=E2=23Qp6wk50=dBnFS6TiCtvphTBMjUywrGg@mail.gmail.com>
Message-ID: <20170525182849.GG18357@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 25, 2017 at 11:30:36PM +0530, Shubham Bansal wrote:
> Actually I intentionally put that print statement their.

Hi Shubham

Please don't top post.  
> Can you tell me what ifdef you removed ?

#ifdef CONFIG_CPU_LITTLE_ENDIAN

Since i said, ARM does not seem to use it.

      Andrew
