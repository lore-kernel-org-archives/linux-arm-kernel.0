From: dave@sr71.net (Dave Hansen)
Date: Thu, 02 Jan 2014 14:13:39 -0800
Subject: [RFC PATCHv3 06/11] arm: use is_vmalloc_addr
In-Reply-To: <1388699609-18214-7-git-send-email-lauraa@codeaurora.org>
References: <1388699609-18214-1-git-send-email-lauraa@codeaurora.org>
 <1388699609-18214-7-git-send-email-lauraa@codeaurora.org>
Message-ID: <52C5E493.6090007@sr71.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/2014 01:53 PM, Laura Abbott wrote:
> is_vmalloc_addr already does the range checking against VMALLOC_START and
> VMALLOC_END. Use it.

FWIW, these first 6 look completely sane and should get merged
regardless of what gets done with the rest.
