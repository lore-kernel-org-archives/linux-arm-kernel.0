From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 12 Sep 2017 15:21:38 +0200
Subject: [media] s5p-mfc: Adjust a null pointer check in four functions
In-Reply-To: <a68020cc-2477-5d6c-bc61-d753253b755a@users.sourceforge.net>
References: <482a6c92-a85e-0bcd-edf7-3c2f63ea74c5@users.sourceforge.net>
 <e794361b-8f2a-7457-007f-72ef4fa66d02@users.sourceforge.net>
 <CGME20170911092134epcas2p1a1b11c056b52d68c3b0e4ea2e1e8f758@epcas2p1.samsung.com>
 <6c2d20b3-4437-0473-73d4-73c049ba52a9@samsung.com>
 <a68020cc-2477-5d6c-bc61-d753253b755a@users.sourceforge.net>
Message-ID: <0fa9a180-be67-3a33-682c-bff819c36c6a@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2017 09:21 PM, SF Markus Elfring wrote:
>>> Date: Fri, 8 Sep 2017 22:37:00 +0200
>>> MIME-Version: 1.0
>>> Content-Type: text/plain; charset=UTF-8
>>> Content-Transfer-Encoding: 8bit
>>
>> Can you resend with that 4 lines removed?
> 
> * Do you care to preserve an information like the author date?

In this case not, but actually the Date line is not an issue.  Anyway
the patch is malformed, please try to save your posted patch and apply
with git am and see how finally the commit message looks like.

> * Would you like to support special characters in the commit message?

I can't see any need for special characters in the patch itself.
Please submit the patch in a way that it can be applied properly with
patchwork client (or git am).

>> Are you using git send-email for sending patches?
> 
> Not so far.

I would suggest switching to git send-email, then issues like
above could be easily avoided.

--
Regards,
Sylwester
