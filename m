From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 7 Jan 2016 20:56:45 +0100
Subject: net-thunder: One check less in nicvf_register_interrupts() after
 error detection
In-Reply-To: <1452195846.4028.24.camel@perches.com>
References: <566ABCD9.1060404@users.sourceforge.net>
 <5685A273.6070607@users.sourceforge.net>
 <20160107110701.GE25086@rric.localdomain>
 <568EBCE7.4060502@users.sourceforge.net>
 <1452195846.4028.24.camel@perches.com>
Message-ID: <568EC2FD.9000702@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Is it a bit more efficient to avoid a double check for the
>> variable "ret" at the end of the current implementation for the
>> discussed function?
> 
> Before asking questions you could answer yourself,
> please look at object code produced by the compiler
> before and after your proposed changes.

* Do any more source code reviewers wonder about the need
  for such a double check?

* Which object code representations would you find representative
  for a further constructive discussion around this
  software component?

Regards,
Markus
