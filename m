From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 10 Jul 2018 11:01:22 -0300
Subject: [PATCH 1/3] ARM: dts: imx53: Add 'ARM platform' node
In-Reply-To: <20180628032158.GG22683@dragon>
References: <1529329939-14117-1-git-send-email-festevam@gmail.com>
 <20180628013530.GE22683@dragon>
 <CAOMZO5CQCTdJC5NOzFGXeHwqkeJmrw9ui0oJ_h=7vFnP5ThUcg@mail.gmail.com>
 <20180628032158.GG22683@dragon>
Message-ID: <CAOMZO5CJofsdkgKYS4exu1ncQWGoR8shnPE1HU7WnNgnSbqzog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Thu, Jun 28, 2018 at 12:21 AM, Shawn Guo <shawnguo@kernel.org> wrote:

> Isn't 'ARM platform' something ARM core specific rather than i.MX?

i.MX51 Reference Manual names this region as 'tigerp', so I sent a v2
referring to this term and also added dt-bindings.
