From: brouer@redhat.com (Jesper Dangaard Brouer)
Date: Tue, 10 Oct 2017 16:00:57 +0200
Subject: [PATCH v2] XDP Program for Ip forward
In-Reply-To: <20171010151231.69fde82f@redhat.com>
References: <1507620532-25804-1-git-send-email-Christina.Jacob@cavium.com>
 <20171010151231.69fde82f@redhat.com>
Message-ID: <20171010160057.32678367@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Oct 2017 15:12:31 +0200
Jesper Dangaard Brouer <brouer@redhat.com> wrote:

> I'll try to test/benchmark your program...

In my initial testing, I cannot get this to work...

You do seem to XDP_REDIRECT out the right interface, but you have an
error with setting the correct MAC address.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
