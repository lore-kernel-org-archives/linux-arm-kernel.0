From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 3 Oct 2013 10:09:14 -0700
Subject: Use of drivers/platform and matching include?
In-Reply-To: <CAOesGMjJ6Uj0uGFJqtnWQyDW+tr6eLVWoHZ+B7uFna+L8N6E8Q@mail.gmail.com>
References: <BC1C47B3-5412-4829-A1D9-AAB04694D1CC@codeaurora.org>
 <CAOesGMjJ6Uj0uGFJqtnWQyDW+tr6eLVWoHZ+B7uFna+L8N6E8Q@mail.gmail.com>
Message-ID: <20131003170914.GA11992@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 09:46:30AM -0700, Olof Johansson wrote:
> I don't have a good answer though. If it wasn't for the arm64 fork,
> locating these under arch/arm somewhere would really be the reasonable
> answer, like we used to do on powerpc. :(

Sounds like yet-another-good reason why there shouldn't be an arm64
"fork" at all :(

The arm community created this mess, you all can fix it up, it's not too
late.

greg k-h
