From: dcashman@android.com (Daniel Cashman)
Date: Wed, 18 Nov 2015 16:16:53 -0800
Subject: [PATCH v3 4/4] x86: mm: support ARCH_MMAP_RND_BITS.
In-Reply-To: <1447888808-31571-5-git-send-email-dcashman@android.com>
References: <1447888808-31571-1-git-send-email-dcashman@android.com>
 <1447888808-31571-2-git-send-email-dcashman@android.com>
 <1447888808-31571-3-git-send-email-dcashman@android.com>
 <1447888808-31571-4-git-send-email-dcashman@android.com>
 <1447888808-31571-5-git-send-email-dcashman@android.com>
Message-ID: <564D14F5.4070407@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2015 03:20 PM, Daniel Cashman wrote:

> -	/*
> -	 *  8 bits of randomness in 32bit mmaps, 20 address space bits
> -	 * 28 bits of randomness in 64bit mmaps, 40 address space bits
> -	 */

This should be removed.
