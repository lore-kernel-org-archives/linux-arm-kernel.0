From: gregkh@suse.de (Greg KH)
Date: Tue, 8 Feb 2011 15:55:45 -0800
Subject: [PATCH 1/2] staging: msm: Use explicit GPLv2 licenses
In-Reply-To: <1297208593-16368-1-git-send-email-davidb@codeaurora.org>
References: <1297208593-16368-1-git-send-email-davidb@codeaurora.org>
Message-ID: <20110208235545.GA2124@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 08, 2011 at 03:43:12PM -0800, David Brown wrote:
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> + * 02110-1301, USA.

This paragraph is not needed at all.  Are you willing to keep track of
the FSF's address changes?  I'm sure not, and it's not relevant for this
file.

Care to redo this for all of these files?

thanks,

greg k-h
