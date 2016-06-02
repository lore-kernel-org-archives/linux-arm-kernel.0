From: jcm@redhat.com (Jon Masters)
Date: Thu, 2 Jun 2016 03:31:38 -0400
Subject: [PATCH V8 0/9] Support for ARM64 ACPI based PCI host controller
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F767865@lhreml507-mbx>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F767865@lhreml507-mbx>
Message-ID: <f606faa9-72f3-3219-02a8-69e948338d2e@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2016 03:36 AM, Gabriele Paoloni wrote:

> If you agree I think Jon can tell who's the best person to
> push the quirk RFC (as my understanding is that this mechanism
> is currently used by some platforms deployed on the market...)

Let me ping Linaro folks to see who has that (quirks) ball. We can
certainly share the older OEM matching quirks Mark Salter did for
earlier RHEL(SA) internal versions as a seed for that[0] activity.

BUT...I don't think we should block this thread on the quirks. They're
separate (but important). I see Arnd's reply as well, but nobody else
has yet chimed in to this thread (and I am about to prod all of the
vendors to reply to this thread and ACK). Can I ask whether we can't
just stage v8 as-is for -next at this point? Can Arnd's (or other)
suggestions be handled as followup patches post-merge please? Bjorn?

Jon.

[0] RHEL(SA) has had three different PCIe enabled ACPI stacks maintained
independently so far since we need PCIe to boot most of the hundreds of
v8 systems we have internal to Red Hat - which all have PCI.

-- 
Computer Architect | Sent from my Fedora powered laptop
