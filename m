From: b.brezillon.dev@gmail.com (Boris BREZILLON)
Date: Thu, 01 May 2014 19:18:44 +0200
Subject: [RFC PATCH 2/3] of: mtd: add NAND randomizer mode retrieval
In-Reply-To: <20140501131605.9CB7CC409DA@trevor.secretlab.ca>
References: <1398906592-24677-1-git-send-email-b.brezillon.dev@gmail.com>	<1398906592-24677-3-git-send-email-b.brezillon.dev@gmail.com>
 <20140501131605.9CB7CC409DA@trevor.secretlab.ca>
Message-ID: <536281F4.1000402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 01/05/2014 15:16, Grant Likely wrote:
> On Thu,  1 May 2014 03:09:51 +0200, Boris BREZILLON <b.brezillon.dev@gmail.com> wrote:
>> Signed-off-by: Boris BREZILLON <b.brezillon.dev@gmail.com>
>> ---
> No commit message? Immediate NAK. Please, make sure you write a
> description for each and every patch. This is not optional. Future
> readers want to know what this patch solves and any other information
> you can provide without having to read the diff.

My bad. I just sent a commit I forgot to rework to add a proper commit
message.
I'll add a commit message describing the different options for the
"nand-rnd-mode" property and update the nand DT bindings documentation.

Best Regards,

Boris
