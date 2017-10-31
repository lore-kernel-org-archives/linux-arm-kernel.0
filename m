From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 31 Oct 2017 10:33:19 -0200
Subject: [PATCH 1/4] Revert "gpio: set up initial state from
 .get_direction()"
In-Reply-To: <a6c8b2ac-29de-4ec7-7b3f-fac1b5b16942@codeaurora.org>
References: <1509396602-1936-1-git-send-email-timur@codeaurora.org>
 <1509396602-1936-2-git-send-email-timur@codeaurora.org>
 <1509440926.10233.77.camel@linux.intel.com>
 <a6c8b2ac-29de-4ec7-7b3f-fac1b5b16942@codeaurora.org>
Message-ID: <CAOMZO5CbPCJe76AMeRHNBUwfEu5jdWUEAqkZuxLBbgOHoLx_MQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 31, 2017 at 10:28 AM, Timur Tabi <timur@codeaurora.org> wrote:

> I ran checkpatch on it and it didn't complain.

In this case checkpatch should have given you an error due to the
missing Signed-off-by tag :-)
