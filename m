From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 15 Mar 2018 15:12:03 -0300
Subject: [GIT PULL 4/6] i.MX device tree updates for 4.17
In-Reply-To: <CAOMZO5BHn+rF5uvJ9Vp7wDSvyVOCAf_kkbR3Lr2EqTX+FFKLvA@mail.gmail.com>
References: <1521113800-16401-1-git-send-email-shawnguo@kernel.org>
 <1521113800-16401-4-git-send-email-shawnguo@kernel.org>
 <CAK8P3a3NXL_0z+Qm1O5Giz3SstGeHd1ghB320b6OSZPOeY1uuA@mail.gmail.com>
 <CAK8P3a09BjAnRWitNbfMFvPr7nwmqcVNi28VK1pRMUu0VUL90w@mail.gmail.com>
 <CAOMZO5BHn+rF5uvJ9Vp7wDSvyVOCAf_kkbR3Lr2EqTX+FFKLvA@mail.gmail.com>
Message-ID: <CAOMZO5DK8+5rYrMbCk9v1maYNcinAiTk0G-=wUD1CR6JLga_KA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 2:22 PM, Fabio Estevam <festevam@gmail.com> wrote:

> My DTC warning patches were generated against Shaw's tree, which is
> based on 4.16-rc1.
>
> In his trees these warnings do not appear, so I haven't fixed them yet.
>
> I can send more patches to fix the remaining i.MX DTC warnings against
> linux-next, but that will probably be for 4.18.

Just tried linux-next and I see that these warnings happen even
without building with W=1.

I will send some patches to fix them.
