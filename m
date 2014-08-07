From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 07 Aug 2014 20:27:44 +0400
Subject: [PATCH v2] usb: gadget: at91_udc: move prepare clk into process
 context
In-Reply-To: <1407424296-12359-1-git-send-email-ronald.wahl@raritan.com>
References: <1407424296-12359-1-git-send-email-ronald.wahl@raritan.com>
Message-ID: <53E3A900.7070702@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08/07/2014 07:11 PM, Ronald Wahl wrote:

> Commit 7628083227b6bc4a7e33d7c381d7a4e558424b6b added clock preparation in

    Please also specify that commit's summary in parens.

> interrupt context. This is not allowed as it might sleep. Move clock
> preparation and setting clock rate into process context (at91udc_probe).

> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>

WBR, Sergei
