From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Mon, 18 Jun 2018 08:58:54 +0000
Subject: [PATCH V2 4/4] soc: imx: add SC firmware IPC and APIs
In-Reply-To: <1529239789-26849-5-git-send-email-aisheng.dong@nxp.com>
References: <1529239789-26849-1-git-send-email-aisheng.dong@nxp.com>
 <1529239789-26849-5-git-send-email-aisheng.dong@nxp.com>
Message-ID: <40fec78ccd4c2f1707396e75219016b3f9fa4522.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2018-06-17 at 20:49 +0800, Dong Aisheng wrote:
> The System Controller Firmware (SCFW) is a low-level system function
> which runs on a dedicated Cortex-M core to provide power, clock, and
> resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
> (QM, QP), and i.MX8QX (QXP, DX).
> 
> This patch adds the SC firmware service APIs used by the system.
> It mainly consists of two parts:
> 1) Implementation of the IPC functions using MUs (client side).
> 2) SCU firmware services APIs implemented based on RPC calls

Most of the code in this patch is auto-generated but some of it (like
ipc.c) is not. Maybe that part should go to a separate patch?

It's otherwise difficult to tell which parts of this +5000 line patch
should be looked at by a human.
