From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Sat, 10 Mar 2018 22:41:04 +0100
Subject: [PATCH] ARM: BCM5301X: Fix NAND ECC parameters for Linksys
 Panamera
In-Reply-To: <20180310171244.70299-1-npcomplete13@gmail.com>
References: <20180310171244.70299-1-npcomplete13@gmail.com>
Message-ID: <CACna6rz1TeRbPq-60HkHz9A0TDn+iXtmXniE6FCiANpUmV-qrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 March 2018 at 18:12, Vivek Unune <npcomplete13@gmail.com> wrote:
> Using BCH8 gives ecc errors and makes the router unsuable.
> Switching to BCH1 fixes these errors.

Can you provide CFE's log messages starting with
"Decompressing...done" and up to the "Press Ctrl+C to stop in CFE"
please? I'd like to see what NAND info CFE prints there.
