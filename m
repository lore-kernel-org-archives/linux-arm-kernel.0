From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Fri, 28 Aug 2015 12:55:45 -0700
Subject: [PATCH] spmi: pmic-arb: u8 <= 0xff is always true
In-Reply-To: <1440790270-14859-1-git-send-email-sboyd@codeaurora.org>
References: <1440790270-14859-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150828195545.GT13472@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 28 Aug 12:31 PDT 2015, Stephen Boyd wrote:

> Silences this static checker warning:
> 
>  drivers/spmi/spmi-pmic-arb.c:363
>  pmic_arb_write_cmd() warn: always true condition
>  '(opc <= 255) => (0-255 <= 255)'
> 
> Cc: Andy Gross <agross@codeaurora.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
