From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Mar 2018 14:55:32 +0100
Subject: [GIT PULL] Xilinx DT changes for v4.17
In-Reply-To: <8bb0e8ce-54ab-f502-595b-d23de77ece64@monstr.eu>
References: <8bb0e8ce-54ab-f502-595b-d23de77ece64@monstr.eu>
Message-ID: <CAK8P3a2YRidu-LbE5Cu6PQKh8bHGbLLuKKPvz4Xs4YUWNZ8+iw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 8, 2018 at 8:26 AM, Michal Simek <monstr@monstr.eu> wrote:
> Hi,
>
> please pull these DT changes to your tree. All new DTS files were
> reviewed by Rob.
>
> Note: In past I was sending separate pull requests for zynq(arm32) and
> zynqmp(arm64). There is dependency on
> Documentation/devicetree/bindings/arm/xilinx.txt and I have also seen
> you are merging them together that's why only one pull request now.

I would still prefer separate pull requests, unless you are doing one
change across both arch trees. I guess in this case the changes
are very similar anyway, so that's fine.

Pulled into next/dt, thanks!

     Arnd
