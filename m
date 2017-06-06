From: richardcochran@gmail.com (Richard Cochran)
Date: Tue, 6 Jun 2017 20:36:32 +0200
Subject: [PATCH v2 4/4] net: macb: Add hardware PTP support
In-Reply-To: <BN3PR07MB251673623B941CAF5DEAB474C9CB0@BN3PR07MB2516.namprd07.prod.outlook.com>
References: <1496413439-12900-1-git-send-email-rafalo@cadence.com>
 <1496413690-22826-1-git-send-email-rafalo@cadence.com>
 <20170604205516.GA7848@localhost.localdomain>
 <BN3PR07MB251673623B941CAF5DEAB474C9CB0@BN3PR07MB2516.namprd07.prod.outlook.com>
Message-ID: <20170606183632.GB25220@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 06, 2017 at 08:54:50AM +0000, Rafal Ozieblo wrote:
> Would "ENOTSUP" be sufficient ?

You mean EOPNOTSUPP?  Yes, sounds ok to me.  EFAULT is surely wrong.

Thanks,
Richard
