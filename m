From: ronald.wahl@raritan.com (Ronald Wahl)
Date: Thu, 07 Aug 2014 01:45:47 +0200
Subject: [PATCH v2] usb: gadget: at91_udc: move prepare clk into process
 context
References: 1407330702-2926-1-git-send-email-ronald.wahl@raritan.com
Message-ID: <53E2BE2B.6090801@raritan.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-08-06 13:11, Ronald Wahl wrote:
> Commit 7628083227b6bc4a7e33d7c381d7a4e558424b6b added clock preparation in
> interrupt context. This is not allowed as it might sleep. Move clock
> preparation into process context (at91udc_probe).

Add Boris and Felipe to Cc: ...

- ron
