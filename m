From: varkabhadram@gmail.com (Varka Bhadram)
Date: Wed, 05 Nov 2014 17:05:11 +0530
Subject: [PATCH V2 1/4] can: m_can: update to support CAN FD features
In-Reply-To: <1415174326-6623-1-git-send-email-b29396@freescale.com>
References: <1415174326-6623-1-git-send-email-b29396@freescale.com>
Message-ID: <545A0B6F.8060706@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong Aisheng,

On 11/05/2014 01:28 PM, Dong Aisheng wrote:

> Bosch M_CAN is CAN FD capable device. This patch implements the CAN
> FD features include up to 64 bytes payload and bitrate switch function.
> 1) Change the Rx FIFO and Tx Buffer to 64 bytes for support CAN FD
>     up to 64 bytes payload. It's backward compatible with old 8 bytes
>     normal CAN frame.
> 2) Allocate can frame or canfd frame based on EDL bit
> 3) Bitrate Switch function is disabled by default and will be enabled
>     according to CANFD_BRS bit in cf->flags.
>
> Signed-off-by: Dong Aisheng <b29396@freescale.com>

In these four patches two of them are V1 and other two are V2.

Is there any reason..?

How will you be able to generate like this by git format-patch..?

-- 
Thanks and Regards,
Varka Bhadram.
