From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Thu, 26 Oct 2017 00:53:28 -0600
Subject: [PATCH 0/2] Fix s5p-mfc lock contention in request firmware paths
In-Reply-To: <CAM3PiRzS966v=pWRq641sFF-Kg5wHc6fH524CQKusURNfcD0ew@mail.gmail.com>
References: <cover.1507325072.git.shuahkh@osg.samsung.com>
 <354e3c31-e502-5ba6-d705-9d67764e78bf@osg.samsung.com>
 <CAM3PiRzS966v=pWRq641sFF-Kg5wHc6fH524CQKusURNfcD0ew@mail.gmail.com>
Message-ID: <ddde8616-6bbc-266b-f28c-3f6125ce5027@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2017 04:28 PM, Marian Mihailescu wrote:
> Hi Shuah,
> 
> For MFC patch, you can delete the "dev" variable since it's not being
> used anymore and results in a compile warning.
> 
> - struct s5p_mfc_dev *dev = ctx->dev;
> 
> Cheers,
> Marian

Oops. I thought I handled that. I will fix that and resend the patch.

thanks,
-- Shuah
